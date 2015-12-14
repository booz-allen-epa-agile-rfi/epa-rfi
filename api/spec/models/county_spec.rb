describe 'County' do
  it 'returns an accurate count of counties' do
    state1 =  create :state
    county1 =  create(:county, state: state1)
    county2 =  create(:county, state: state1)
    expect(County.count).to eq 2
  end
end


