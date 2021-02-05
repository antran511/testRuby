require 'rspec'

describe BaggageClaim do
  before do
    @bags = {
      '982734' => { :name => 'Jon Snow',            :departed_from => 'St Louis', :status => 'In Transit' },
      '414028' => { :name => 'Tyrion Lannister',    :departed_from => 'Phoenix',  :status => 'Lost' },
      '127407' => { :name => 'Sansa Stark',         :departed_from => 'LA',       :status => 'Delivered' },
      '368934' => { :name => 'Daenerys Targaryen',  :departed_from => 'NYC',      :status => 'Delivered' },
      '709289' => { :name => 'Jorah Mormont',       :departed_from => 'Phoenix',  :status => 'In Transit' },
    }
  end

  it 'has dynamic method names based on the departed_from city' do
    expect(BaggageClaim.new(@bags).from_phoenix).to eq({
      '414028' => { :name => 'Tyrion Lannister',    :departed_from => 'Phoenix',  :status => 'Lost' },
      '709289' => { :name => 'Jorah Mormont',       :departed_from => 'Phoenix',  :status => 'In Transit' },
    })

    expect(BaggageClaim.new(@bags).from_st_louis).to eq({
      "982734"=>{:name=>"Jon Snow", :departed_from=>"St Louis", :status=>"In Transit"}
    })
  end

  it 'can group by statuses' do
    expect(BaggageClaim.new(@bags).status('Delivered')).to eq([
      ["127407", {:name=>"Sansa Stark", :departed_from=>"LA", :status=>"Delivered"}],
      ["368934", {:name=>"Daenerys Targaryen", :departed_from=>"NYC", :status=>"Delivered"}]
    ])
  end
end

