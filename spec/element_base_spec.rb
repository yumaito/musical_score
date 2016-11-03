require 'spec_helper'

describe MusicalScore::ElementBase do
    it do
        expect{ MusicalScore::ElementBase.create_by_xml(dummy_xml) }.to raise_error(RuntimeError)
    end
end