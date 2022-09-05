require 'rails_helper'

RSpec.describe 'it has a projects show page' do
  before :each do
    @jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    @jay_project = @jay.contestant_projects.create!(contestant_id: @jay.id, project_id: @news_chic.id)
    @gretchen_project = @gretchen.contestant_projects.create!(contestant_id: @gretchen.id, project_id: @news_chic.id)


  end

  it 'shows the projects name, material and theme' do
    visit "/projects/#{@news_chic.id}"

    expect(current_path).to eq("/projects/#{@news_chic.id}")
    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content(@news_chic.material)
    expect(page).to have_content(@recycled_material_challenge.theme)
  end

  it 'shows the count of the number of contestants on this project' do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Number of Contestants: 2")
  end
end
