require 'spec_helper'

describe Product do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:price) }

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }

    it { should allow_value("image.png").for(:image_url) }
    it { should allow_value("image.jpg").for(:image_url) }
    it { should allow_value("image.gif").for(:image_url) }
    it { should_not allow_value("image.txt").for(:image_url) }

    it { should have_many(:line_items) }
  end

  it "should not allow deletion if there are associated line_items" do
    product = FactoryGirl.create(:product)
    product.line_items.create(:cart => FactoryGirl.create(:cart))

    expect(product.destroy).to be_false
    expect(product.errors.full_messages).to include("Line items are present")
  end
end
