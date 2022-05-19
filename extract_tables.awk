BEGIN {
    LAST_LINE_NUMBER=-10
    FS="|"
    OFS="\t"
    print "verified_system", "verified_filename", "verified_md5sum"
}
function systemname(file) {
    n = match(file, /([^\/]+)\.[a-z]+/, ar)
    if (n == 0) {
        return "UNKNOWN"
    }
    return ar[1]
}
{
    IN_TABLE=0
    NEW_TABLE=0
    TABLE_SEPERATOR=0
}
(NF > 1) && (/^\s*\|.*\|\s*/) {
    if (LAST_LINE_NUMBER != NR-1) {
        NEW_TABLE=1
    }
    LAST_LINE_NUMBER=NR
    IN_TABLE=1
}
/^\s*\|(\-|:)(\-|:|\|)+\|\s*/ {
    TABLE_SEPERATOR=1
}
IN_TABLE {
    for(i=1; i<=NF; i++) {
        gsub(/\s*$/, "", $(i))
        gsub(/^\s*/, "", $(i))
    }
}
NEW_TABLE {
    CORRECT_TABLE = 0
}
(NEW_TABLE) && (NF > 0) && (match($(NF - 1), "^md5sum") == 1) {
    CORRECT_TABLE=1
    FILENAME_INDEX=-1
    for(i=1; i<=NF; i++) {
        if ($(i) == "Filename") {
            FILENAME_INDEX = i
        }
    }
}
(IN_TABLE == 1) && (NEW_TABLE == 0) && (CORRECT_TABLE) && (TABLE_SEPERATOR == 0) {
    print systemname(FILENAME), $(FILENAME_INDEX), tolower($(NF - 1))
}
