require 'spec_helper'

describe LayoutHelper do
  describe '#show_layout_flash?' do
    it 'should return true if layout_flash is nil' do
      @layout_flash = nil
      expect(show_layout_flash?).to be_truthy
    end
    it 'should return layout_flash if layout_flash not nil' do
      @layout_flash = "layout flash"
      expect(show_layout_flash?).to eq(@layout_flash)
    end
  end
  describe '#flash_messages' do
    before do
      flash[:notice] = 'notice flash'
      flash[:error] = 'error flash'
      @opts = {
        :layout_flash => 'flash'
      }
    end
    it 'should set @layout_flash from passed hash' do
      flash_messages(@opts)
      expect(@layout_flash).to eq(@opts[:layout_flash])
    end
    it 'should return div with flash' do
      output = flash_messages(@opts)
      flash.each do |name, msg| 
        output.should have_css "div#flash_#{name}"
        output.should have_text "#{msg}"
      end
      output.should have_css("div", :count => flash.to_hash().length)
    end
  end
end