FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    # 下記未検証
    # password_digest { <%= User.digest('foobar') %> }
  end

  factory :user2, class: User do
    name { 'mike' }
    email { 'mike@gmailgmail.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
