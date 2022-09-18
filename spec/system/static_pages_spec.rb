require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  feature 'static_pages', type: :system do
    scenario 'ルートパスでリンクが有効である' do
      get root_path
      expect(response).to render_template 'static_pages/home'
      assert_select 'a[href=?]', root_path, count: 2
      assert_select 'a[href=?]', help_path
      assert_select 'a[href=?]', about_path
      assert_select 'a[href=?]', contact_path
      assert_select 'a[href=?]', signup_path
    end
  end

  def document_root_element
    html_document.root
  end
end
