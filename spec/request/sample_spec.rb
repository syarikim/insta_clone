# frozen_string_literal: true
require 'rails_helper'

RSpec.describe('Samples', type: :system) do
  describe 'TOP画面にアクセスしたとき' do
    subject { get '/' }
    it 'httpステータスが200で返ってくる' do
      subject
      expect(response).to have_http_status(200)
    end
  end
end
