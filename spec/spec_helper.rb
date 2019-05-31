require 'dropbox_api'
require 'support/vcr'
require File.expand_path('../support/dropbox_scaffold_builder', __FILE__)

ENV["DROPBOX_OAUTH_BEARER"] ||= "MOCK_AUTHORIZATION_BEARER"
