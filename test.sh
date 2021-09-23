#!/bin/bash

pytest --keep-workflow-wd-on-fail --tag  "$@" --symlink tests/