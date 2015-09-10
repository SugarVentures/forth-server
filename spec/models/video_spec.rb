require 'rails_helper'

RSpec.describe Video, type: :model do
  it { is_expected.to validate_presence_of :file }

  it { is_expected.to belong_to(:stream) }
end
