

require 'rubygems'
require 'activesupport'
require 'hpricot'


class STDParser 
  include Singleton
  
  attr_accessor :std_data
  
  def initialize
    self.std_data = []
    doc = Hpricot(open('doc/std_codes.html'))
    (doc/"//td//table/tr/td/font")[4..-1].in_groups_of(3) do |table| 
      if table[2] 
        std_data <<  { 
          'area' => table[0].inner_html, 
          'state' => table[1].inner_html, 
          'code_prefix' => table[2].inner_html.gsub("\r", '')
        }
      end
    end
  end
  
  def dump
    std_data
  end
  
  def query(number)
    number.gsub!(/^0+/, '') #strip zeroes from beginning
    result = std_data.find { |datum| number.match(/^#{datum['code_prefix']}/)  }
    result ||= { 'area' => 'Unknown', 'state' => 'Unknown', 'code_prefix' => 'Unknown' }
  end
end


