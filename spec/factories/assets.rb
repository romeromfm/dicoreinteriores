include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :asset do
    file { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'), 'image/png') }
  end
end
