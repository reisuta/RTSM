module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  # 大文字にして返す遊びメソッド
  def yeller(args = []) # yeller(['o', 'l', 'd']) => "OLD"
    return if args === []
    args.map(&:upcase).join
  end
end
