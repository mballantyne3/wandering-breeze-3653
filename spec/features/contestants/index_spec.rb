require 'rails_helper'

RSpec.describe 'it has a contestants index page' do
  before :each do
    @jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create!(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create!(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    @recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
    @jay_project = @jay.contestant_projects.create!(contestant_id: @jay.id, project_id: @news_chic.id)

  end

  it 'has a valid path' do
    visit "/contestants"

    expect(current_path).to eq("/contestants")
  end

  it 'lists the names of all contestants' do
    visit "/contestants"

    expect(page).to have_content(@jay.name)
    expect(page).to have_content(@gretchen.name)
    expect(page).to have_content(@kentaro.name)
    expect(page).to have_content(@erin.name)
  end

  it 'lists the projects each contestant was involved in' do
    visit "/contestants"

    within "#contestantProjects" do
      expect(page).to have_content("Name: Jay")
      expect(page).to have_content("Affiliated projects: News Chic")
    end
  end
end
