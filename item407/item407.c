
#include <stdlib.h>
#include <stdio.h>
#include "sqlite3.h"

const char* databasePath = "/Users/eric/dev/cb/item407/storage.ide";

// from Query2, slash included
const char* query2 = "attach database 'file:///Users/eric/dev/cb/item407/storage.ide/?mode=memory&cache=shared' as writecache;";

// from Query 3, no slash
const char* query3 = "attach database 'file:///Users/eric/dev/cb/item407/storage.ide?mode=memory&cache=shared' as writecache;";

void show_err(sqlite3* db, const char* psz, int rc)
{
    switch (rc)
    {
        case SQLITE_OK:
            printf("%s %d\n", psz, rc);
            break;
        case SQLITE_ROW:
            printf("%s %d\n", psz, rc);
            break;
        case SQLITE_DONE:
            printf("%s %d\n", psz, rc);
            break;
        default:
            printf("%s %d -- %s -- %s\n", psz, rc, sqlite3_errmsg(db), sqlite3_errstr(sqlite3_extended_errcode(db)));
            break;
    }
}

int main()
{
    // see https://sqlite.org/threadsafe.html for more detail
    int flags = SQLITE_OPEN_CREATE |
        SQLITE_OPEN_READWRITE |
        SQLITE_OPEN_NOMUTEX |
        SQLITE_OPEN_SHAREDCACHE |
        SQLITE_OPEN_URI;
    sqlite3* db;
    sqlite3_stmt* stmt;

    int rc = sqlite3_open_v2(databasePath, &db, flags, NULL);
    show_err(db, "open", rc);

    rc = sqlite3_prepare_v2(db, query3, -1, &stmt, NULL);
    show_err(db, "prepare", rc);

    rc = sqlite3_step(stmt);
    show_err(db, "step", rc);

    rc = sqlite3_close_v2(db);
    show_err(db, "close", rc);

    return 0;
}

