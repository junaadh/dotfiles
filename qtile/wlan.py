#!/usr/bin/env python

import iwlib

def wlan_status(interface_name):
    interface = iwlib.get_iwconfig(interface_name)
    if interface is None:
        return None, None
    ssid = interface['ESSID'].decode()
    return ssid
