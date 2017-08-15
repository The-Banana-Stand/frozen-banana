require 'rails_helper'

RSpec.describe 'static_pages', type: :request do
  describe 'error' do
    it 'raises an error' do
      expect{get '/error'}.to raise_error(RuntimeError)
    end
  end
end