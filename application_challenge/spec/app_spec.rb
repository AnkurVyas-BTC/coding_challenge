# frozen_string_literal: true

require File.expand_path 'spec_helper.rb', __dir__

describe 'My Sinatra Application' do
  let(:my_app) { RSpec::ExampleGroups::MySinatraApplication }

  context '#call' do
    it 'makes api call and save data to database' do
      expect_any_instance_of(my_app).to receive(:api_response)
      expect_any_instance_of(my_app).to receive(:save_to_database)

      call
    end
  end

  context '#api_response' do
    let(:fake_response) { double }

    it 'calls API and give json response' do
      allow(fake_response).to receive(:body).and_return('{"response":"test"}')
      allow(Net::HTTP).to receive(:get_response).and_return(fake_response)

      result = api_response
      expect(result).to eq('response' => 'test')
    end
  end

  context '#initialize_visit' do
    let(:input) do
      {
        'referrerName' => 'Test name',
        'idSite' => '209',
        'idVisit' => '134853732',
        'visitIp' => '24.6.5.33',
        'visitoriId' => 'e280af5191b64f18'
      }
    end

    it 'initializes visit with the result' do
      result = initialize_visit(input)

      expect(result.class).to be(Visit)
      expect(result.evid).to eq 'Test name'
      expect(result.vendor_site_id).to eq '209'
      expect(result.vendor_visit_id).to eq '134853732'
      expect(result.visit_ip).to eq '24.6.5.33'
      expect(result.vendor_visitor_id).to eq 'e280af5191b64f18'


    end
  end

  context '#save_to_database' do
    context 'for appropriate response' do
      it 'creates visit and pageviews in database' do
        expect(Visit.count).to be_zero
        expect(Pageview.count).to be_zero

        save_to_database(sample_response)

        expect(Visit.count).to be_positive
        expect(Pageview.count).to be_positive
      end
    end

    context 'for inappropriate response' do
      it 'does not save visit and pageviews in database' do
        expect(Visit.count).to be_zero
        expect(Pageview.count).to be_zero

        save_to_database(incorrect_response)

        expect(Visit.count).to be_zero
        expect(Pageview.count).to be_zero
      end
    end
  end


  context '#save_pageviews' do
    let(:input) do
      {
        'evid' => 'evid_966634dc-0bf6-1ff7-f4b6-08000c95c670',
        'vendor_site_id' => '209',
        'vendor_visit_id' => '134853732',
        'visit_ip' => '24.6.5.33',
        'vendor_visitor_id' => 'e280af5191b64f18'
      }
    end

    context 'for appropriate response' do
      it 'creates pageviews in database' do
        expect(Visit.count).to be_zero
        expect(Pageview.count).to be_zero
        visit = Visit.create(input)

        save_pageviews(sample_response.first[:actionDetails], visit)

        expect(Pageview.count).to be_positive
      end
    end
  end

  # Can be moved to fixtures
  def sample_response
    [
      {
        "idSite": '209',
        "idVisit": '134853732',
        "visitIp": '24.6.5.33',
        "visitorId": 'e280af5191b64f18',
        "actionDetails": [
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:45:18',
            "pageId": '548144655',
            "generationTime": '0.3s',
            "timeSpent": '50',
            "timeSpentPretty": '50s',
            "icon": nil,
            "timestamp": 1_537_623_918
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:39:39',
            "pageId": '548143378',
            "generationTime": '0.37s',
            "timeSpent": '1',
            "timeSpentPretty": '1s',
            "icon": nil,
            "timestamp": 1_537_623_579
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:39:40',
            "pageId": '548143381',
            "generationTime": '0.37s',
            "timeSpent": '337',
            "timeSpentPretty": '5 min 37s',
            "icon": nil,
            "timestamp": 1_537_623_580
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:45:17',
            "pageId": '548144653',
            "generationTime": '0.3s',
            "timeSpent": '1',
            "timeSpentPretty": '1s',
            "icon": nil,
            "timestamp": 1_537_623_917
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:45:18',
            "pageId": '548144655',
            "generationTime": '0.3s',
            "timeSpent": '50',
            "timeSpentPretty": '50s',
            "icon": nil,
            "timestamp": 1_537_623_918
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&time=1-45-pm&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2728749',
            "serverTimePretty": 'Sep 22, 2018 13:46:08',
            "pageId": '548144881',
            "generationTime": '0.29s',
            "timeSpent": '1',
            "timeSpentPretty": '1s',
            "icon": nil,
            "timestamp": 1_537_623_968
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&time=1-45-pm&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2728749',
            "serverTimePretty": 'Sep 22, 2018 13:46:09',
            "pageId": '548144886',
            "generationTime": '0.29s',
            "timeSpent": '463',
            "timeSpentPretty": '7 min 43s',
            "icon": nil,
            "timestamp": 1_537_623_969
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:53:52',
            "pageId": '548146737',
            "generationTime": '0.33s',
            "timeSpent": '1',
            "timeSpentPretty": '1s',
            "icon": nil,
            "timestamp": 1_537_624_432
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:53:53',
            "pageId": '548146740',
            "generationTime": '0.33s',
            "timeSpent": '1161',
            "timeSpentPretty": '19 min 21s',
            "icon": nil,
            "timestamp": 1_537_624_433
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=evid&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2728779',
            "serverTimePretty": 'Sep 22, 2018 14:13:14',
            "pageId": '548151026',
            "generationTime": '0.31s',
            "timeSpent": '1',
            "timeSpentPretty": '1s',
            "icon": nil,
            "timestamp": 1_537_625_594
          },
          {
            "type": 'action',
            "url": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx/vehicle-loan-information?lenderref=Meriwest_test&evid=evid&l=1',
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2728779',
            "serverTimePretty": 'Sep 22, 2018 14:13:15',
            "pageId": '548151027',
            "generationTime": '0.31s',
            "icon": nil,
            "timestamp": 1_537_625_595
          }
        ],
        "goalConversions": 0,
        "siteCurrency": 'USD',
        "siteCurrencySymbol": '$',
        "serverDate": '2018-09-22',
        "visitServerHour": '21',
        "lastActionTimestamp": 1_537_650_795,
        "lastActionDateTime": '2018-09-22 21:13:15',
        "userId": nil,
        "visitorType": 'returning',
        "visitorTypeIcon": 'plugins/Live/images/returningVisitor.gif',
        "visitConverted": '0',
        "visitConvertedIcon": nil,
        "visitCount": '3',
        "firstActionTimestamp": 1_537_648_779,
        "visitEcommerceStatus": 'none',
        "visitEcommerceStatusIcon": nil,
        "daysSinceFirstVisit": '0',
        "daysSinceLastEcommerceOrder": '0',
        "visitDuration": '2017',
        "visitDurationPretty": '33 min 37s',
        "searches": '0',
        "actions": '10',
        "referrerType": 'campaign',
        "referrerTypeName": 'Campaigns',
        "referrerName": 'evid_966634dc-0bf6-1ff7-f4b6-08000c95c670',
        "referrerKeyword": 'apptest.loanspq.com',
        "referrerKeywordPosition": nil,
        "referrerUrl": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx?enc=li4vaDVj_-KYKOppTSH6EAi8DUDq8STa30c_DCm3YiF8QRdk5UCGkWYcLDkeFeMbxOpvYi_p3BIa_jm7FZbQqFJ-z15NQLKyeR42Sau7hee1R3eVee7IcblL2VWtEveE',
        "referrerSearchEngineUrl": nil,
        "referrerSearchEngineIcon": nil,
        "languageCode": 'en-us',
        "language": 'Language code en-us',
        "deviceType": 'Desktop',
        "deviceTypeIcon": 'plugins/DevicesDetection/images/screens/normal.gif',
        "deviceBrand": 'Unknown',
        "deviceModel": '',
        "operatingSystem": 'Mac 10.13',
        "operatingSystemName": 'Mac',
        "operatingSystemIcon": 'plugins/DevicesDetection/images/os/MAC.gif',
        "operatingSystemCode": 'MAC',
        "operatingSystemVersion": '10.13',
        "browserFamily": 'Blink',
        "browserFamilyDescription": 'Blink (Chrome, Opera)',
        "browser": 'Chrome 68.0',
        "browserName": 'Chrome',
        "browserIcon": 'plugins/DevicesDetection/images/browsers/CH.gif',
        "browserCode": 'CH',
        "browserVersion": '68.0',
        "events": '0',
        "continent": 'North America',
        "continentCode": 'amn',
        "country": 'United States',
        "countryCode": 'us',
        "countryFlag": 'plugins/UserCountry/images/flags/us.png',
        "region": 'California',
        "regionCode": 'CA',
        "city": 'Hercules',
        "location": 'Hercules, California, United States',
        "latitude": '38.009998',
        "longitude": '-122.259003',
        "visitLocalTime": '13:39:38',
        "visitLocalHour": '13',
        "daysSinceLastVisit": '0',
        "resolution": '2560x1440',
        "plugins": 'pdf',
        "pluginsIcons": [
          {
            "pluginIcon": 'plugins/DevicePlugins/images/plugins/pdf.gif',
            "pluginName": 'pdf'
          }
        ],
        "provider": 'comcast.net',
        "providerName": 'Comcast',
        "providerUrl": 'http://www.comcast.net/',
        "serverTimestamp": 1_537_650_795,
        "serverTimePretty": '14:13:15',
        "serverDatePretty": 'Saturday, September 22, 2018',
        "serverDatePrettyFirstAction": 'Saturday, September 22, 2018',
        "serverTimePrettyFirstAction": '13:39:39'
      }
    ]
  end

  def incorrect_response
    [
      {
        "idSite": '209',
        "idVisit": '134853732',
        "visitIp": '24.6.5.33',
        "visitorId": 'e280af5191b64f18',
        "actionDetails": [
          {
            "type": 'action',
            "url": nil,
            "pageTitle": 'Vehicle Loan Information',
            "pageIdAction": '2683026',
            "serverTimePretty": 'Sep 22, 2018 13:45:18',
            "pageId": '548144655',
            "generationTime": '0.3s',
            "timeSpent": '50',
            "timeSpentPretty": '50s',
            "icon": nil,
            "timestamp": 1_537_623_918
          }
        ],
        "goalConversions": 0,
        "siteCurrency": 'USD',
        "siteCurrencySymbol": '$',
        "serverDate": '2018-09-22',
        "visitServerHour": '21',
        "lastActionTimestamp": 1_537_650_795,
        "lastActionDateTime": '2018-09-22 21:13:15',
        "userId": nil,
        "visitorType": 'returning',
        "visitorTypeIcon": 'plugins/Live/images/returningVisitor.gif',
        "visitConverted": '0',
        "visitConvertedIcon": nil,
        "visitCount": '3',
        "firstActionTimestamp": 1_537_648_779,
        "visitEcommerceStatus": 'none',
        "visitEcommerceStatusIcon": nil,
        "daysSinceFirstVisit": '0',
        "daysSinceLastEcommerceOrder": '0',
        "visitDuration": '2017',
        "visitDurationPretty": '33 min 37s',
        "searches": '0',
        "actions": '10',
        "referrerType": 'campaign',
        "referrerTypeName": 'Campaigns',
        "referrerName": 'incorrect_format',
        "referrerKeyword": 'apptest.loanspq.com',
        "referrerKeywordPosition": nil,
        "referrerUrl": 'https://apptest.loanspq.com/vl/VehicleLoan.aspx?enc=li4vaDVj_-KYKOppTSH6EAi8DUDq8STa30c_DCm3YiF8QRdk5UCGkWYcLDkeFeMbxOpvYi_p3BIa_jm7FZbQqFJ-z15NQLKyeR42Sau7hee1R3eVee7IcblL2VWtEveE',
        "referrerSearchEngineUrl": nil,
        "referrerSearchEngineIcon": nil,
        "languageCode": 'en-us',
        "language": 'Language code en-us',
        "deviceType": 'Desktop',
        "deviceTypeIcon": 'plugins/DevicesDetection/images/screens/normal.gif',
        "deviceBrand": 'Unknown',
        "deviceModel": '',
        "operatingSystem": 'Mac 10.13',
        "operatingSystemName": 'Mac',
        "operatingSystemIcon": 'plugins/DevicesDetection/images/os/MAC.gif',
        "operatingSystemCode": 'MAC',
        "operatingSystemVersion": '10.13',
        "browserFamily": 'Blink',
        "browserFamilyDescription": 'Blink (Chrome, Opera)',
        "browser": 'Chrome 68.0',
        "browserName": 'Chrome',
        "browserIcon": 'plugins/DevicesDetection/images/browsers/CH.gif',
        "browserCode": 'CH',
        "browserVersion": '68.0',
        "events": '0',
        "continent": 'North America',
        "continentCode": 'amn',
        "country": 'United States',
        "countryCode": 'us',
        "countryFlag": 'plugins/UserCountry/images/flags/us.png',
        "region": 'California',
        "regionCode": 'CA',
        "city": 'Hercules',
        "location": 'Hercules, California, United States',
        "latitude": '38.009998',
        "longitude": '-122.259003',
        "visitLocalTime": '13:39:38',
        "visitLocalHour": '13',
        "daysSinceLastVisit": '0',
        "resolution": '2560x1440',
        "plugins": 'pdf',
        "pluginsIcons": [
          {
            "pluginIcon": 'plugins/DevicePlugins/images/plugins/pdf.gif',
            "pluginName": 'pdf'
          }
        ],
        "provider": 'comcast.net',
        "providerName": 'Comcast',
        "providerUrl": 'http://www.comcast.net/',
        "serverTimestamp": 1_537_650_795,
        "serverTimePretty": '14:13:15',
        "serverDatePretty": 'Saturday, September 22, 2018',
        "serverDatePrettyFirstAction": 'Saturday, September 22, 2018',
        "serverTimePrettyFirstAction": '13:39:39'
      }
    ]
  end
end
