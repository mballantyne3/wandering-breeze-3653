require 'rails_helper'

RSpec.describe 'it has a projects show page' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
  end

  it 'shows the projects name, material and theme' do
    visit "/projects/#{@news_chic.id}"

    expect(current_path).to eq("/projects/#{@news_chic.id}")
    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content(@news_chic.material)
    expect(page).to have_content(@recycled_material_challenge.theme)
  end
end
