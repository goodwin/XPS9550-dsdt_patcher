#!/bin/bash

hexdump -n3 -e'/3 "00-60-2F" 3/1 "-%02X"' /dev/random

