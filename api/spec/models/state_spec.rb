describe 'State.count' do
  it 'returns an accurate count of states in the database' do
    state1 =  create :state
    state2 =  create :state
    state3 =  create :state
    expect(State.count).to eq 3
  end
end

describe 'State.counties' do
  it 'returns an accurate counties associated with a state in the database' do
    state1 =  create :state
    county1 =  create(:county, state: state1)
    county2 =  create(:county, state: state1)
    state2 =  create :state
    county3 =  create(:county, state: state2)
    expect(state1.counties.count).to eq 2
    expect(state2.counties.count).to eq 1
  end
end



