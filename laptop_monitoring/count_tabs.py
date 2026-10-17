#!/usr/bin/env python3
# Count open tabs from a firefox profile
# Working directory is the root of a Firefox profile.
import json
try:
    import lz4.block as lz4
except ImportError:
    import lz4

f=open("/home/{USER}/snap/firefox/common/.mozilla/firefox/{PROFILE}/sessionstore-backups/recovery.jsonlz4", 'rb')

if f.read(8) != b"mozLz40\0":
    raise ValueError("Invalid magic number")

j = json.loads(lz4.decompress(f.read()))
def info_for_tab(tab):
    try:
        return (tab['entries'][0]['url'], tab['entries'][0]['title'])
    except IndexError:
        return None
    except KeyError:
        return None
def tabs_from_windows(window):
    return list(map(info_for_tab, window['tabs']))
all_tabs = list(map(tabs_from_windows, j['windows']))
print('{tabs}'.format(tabs=sum(map(len, all_tabs))))
