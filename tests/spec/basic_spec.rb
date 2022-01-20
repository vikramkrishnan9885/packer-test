require 'spec_helper'
require 'serverspec'

describe file('/example.txt') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should contain 'FOO is hello world' }
end
