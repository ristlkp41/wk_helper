#!/bin/bash

cd $(dirname $0)
RAILS_ENV=production bundle exec rails server --binding 0.0.0.0
