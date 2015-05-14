#!/bin/bash
bundle install
npm install
PATH=$(npm bin):$PATH bower install
