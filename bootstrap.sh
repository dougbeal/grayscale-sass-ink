#!/bin/bash
env
gem install bundle
bundle install
npm install
PATH=$(npm bin):$PATH bower install
