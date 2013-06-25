require 'spec_helper'

describe "Audible Magic" do
  it "should have amSigGen binary" do
    Hatchet::AnvilApp.new("mri_187").deploy do |app|
      assert(app.run('amSigGen -v'))
    end
  end
end
