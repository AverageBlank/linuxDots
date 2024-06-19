<?php

const TMP_CSV_DATA = 'csv-data.tmp';

/** @noinspection PhpMissingDocCommentInspection */
function getCsvDataForFile(string $fileName): array {
    return array_map('str_getcsv', file($fileName));
}

/** @noinspection PhpMissingDocCommentInspection */
function output(string $contents): void {
    echo "{$contents}\n";
}

$currentEmojiDbFile = __DIR__ . '/emojidb.csv';
$currentEmojiDb = getCsvDataForFile($currentEmojiDbFile);
$currentEmojisByHexCode = array_column($currentEmojiDb, 0, 1);
unset($currentEmojisByHexCode['code']);

$sourceCsvData = 'https://raw.githubusercontent.com/hfg-gmuend/openmoji/master/data/openmoji.csv';

$buildFolder = __DIR__ . '/build/' . date('Y-m-d-H-i-s');
mkdir($buildFolder);

$tmpCsvDataFile = $buildFolder . '/' . TMP_CSV_DATA;
file_put_contents($tmpCsvDataFile, file_get_contents($sourceCsvData));

$data = getCsvDataForFile($tmpCsvDataFile);

$headers = array_shift($data);
if(empty($headers)) {
    echo 'no headers';
    exit;
}

$expectedHeaders = [
    'emoji',
    'hexcode',
    'group',
    'subgroups',
    'annotation',
    'tags',
];

$countExpectedHeaders = count($expectedHeaders);

$firstHeaders = array_slice($headers, 0, $countExpectedHeaders);

if($expectedHeaders !== $firstHeaders) {
    throw new Exception('Headers from remote file do not match expected headers');
}

$partialOpenMojiData = array_map(
    static function(array $data) use ($expectedHeaders, $countExpectedHeaders) {
        return array_combine(
            $expectedHeaders,
            array_slice($data, 0, $countExpectedHeaders, true)
        );
    },
    $data
);

$newData = [];
$lastNumber = !empty($currentEmojisByHexCode)
    ? max(array_values($currentEmojisByHexCode))
    : 0;

output(sprintf(
    "Comparing %d emojis from local db file to %d emojis from origin file...",
    count($currentEmojisByHexCode),
    count($partialOpenMojiData)
));

foreach($partialOpenMojiData as $openMojiData) {
    if(isset($currentEmojisByHexCode[$openMojiData['hexcode']])) {
        continue;
    }

    $name = $openMojiData['annotation'];
    if($openMojiData['group'] === 'extras-openmoji') {
        $name = '(custom openmoji) ' . $name;
    }
    $newData[] = [
        ++$lastNumber,
        $openMojiData['hexcode'],
        $name,
        $name . '; ' . str_replace(',', ';', $openMojiData['tags']),
    ];
}

if(count($newData) === 0) {
    output("No new emojis found, nothing to update! Exiting script...");
    exit;
}

output(sprintf("Found %d new emojis! Adding to local db file...", count($newData)));

$f = fopen($currentEmojiDbFile, 'w+');
$bytesAdded = 0;
array_map(
    static function(array $csvData) use ($f, &$bytesAdded) {
        $bytes = fputcsv($f, $csvData);
        if(false === $bytes) {
            throw new Exception('Could not write to local db file');
        }
        $bytesAdded += $bytes;
    },
    array_merge($currentEmojiDb, $newData)
);
fclose($f);

output(sprintf("Closed local db file, appended %d bytes!", $bytesAdded));

output('Unzipping emoji images from origin...');
$sourceColourImages = 'https://github.com/hfg-gmuend/openmoji/releases/latest/download/openmoji-72x72-color.zip';

$imagesZip = $buildFolder . '/Images.zip';
file_put_contents($imagesZip, file_get_contents($sourceColourImages));
$zip = new ZipArchive();
$openedZip = $zip->open($imagesZip);
if(true !== $openedZip) {
    throw new Exception('Could not open zip');
}
mkdir($buildFolder . '/Images');
mkdir($buildFolder . '/Images/Emojis');
$zip->extractTo($buildFolder . '/Images/Emojis');
$zip->close();

output('Unzipped! Putting them in the proper directory...');
copy(__DIR__ . '/icon.png', $buildFolder . '/Images/icon.png');

$githubIconUrl = 'https://raw.githubusercontent.com/hfg-gmuend/openmoji/master/color/72x72/%s.png';
foreach($newData as $newIcon) {
    [$num, $id, $description] = $newIcon;
    $fileLocation = sprintf('%s/Images/Emojis/%s.png', $buildFolder, $id);
    if(!file_exists($fileLocation)) {
        output("Icon {$id} did not exist, getting from Github...");
        if(!file_put_contents(
            $fileLocation,
            file_get_contents(sprintf($githubIconUrl, $id))
        )) {
            throw new Exception('Could not get icon from GitHub');
        }
    }
}

output("[!!!] Creating zip automagically doesn't work... please zip the files manually.");
if(false) {
    /** @noinspection PhpUnreachableStatementInspection */
    $newZipArchiveName = $buildFolder . '/Images-' . uniqid() . '.zip';
    $zip = new ZipArchive();
    $openedZip = $zip->open($newZipArchiveName, ZipArchive::CREATE | ZipArchive::OVERWRITE);
    if(true !== $openedZip) {
        throw new Exception('Could not open/create/overwrite zip');
    }
    /** @var string[] $added */
    $added = $zip->addGlob($buildFolder . '/Images/Emojis/*');
    if($zip->status !== ZIPARCHIVE::ER_OK) {
        throw new Exception('Could not add all emoji images');
    }
    /** @var string[] $added2 */
    $added2 = $zip->addGlob($buildFolder . '/Images/*');
    if($zip->status != ZIPARCHIVE::ER_OK) {
        throw new Exception('Could not add all remaining images');
    }

    $filesToCheck = array_merge($added, $added2);
    foreach($filesToCheck as $test) {
        if(!file_exists($test)) {
            throw new Exception(sprintf('Added file %s does not actually exist', $test));
        }
    }

    output(sprintf("All files checked (%d); they exist!", count($filesToCheck)));
    output(sprintf("Added %d and %d files to zip archive!", count($added), count($added2)));
    $zip->close();
}

output('All done! You should have two unstaged changes: Images.zip and emojidb.csv.');
