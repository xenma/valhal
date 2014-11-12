# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HttpService do

  before do
    HttpService.new
  end

  describe '#do_post?' do
    it 'should return a string containing XML from a HTTP request to Aleph' do
      http_service = HttpService.new
      xml_response = http_service.do_post(
                                          'http://rex.kb.dk/X', 
                                          params = {
                                            "op"      => "find",
                                            "base"    => "kgl01",
                                            "code"    => "",
                                            "request" => "isbn=9788711396322"
                                          }
                                          )
      puts xml_response
    end
  end
end
