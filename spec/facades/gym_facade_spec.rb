require 'rails_helper'

describe GymFacade, type: :facade do
  describe 'class methods' do
    describe '.get_gym_users' do
      context 'when the gym has members' do
        it 'returns User objects' do
          yelp_gym_id = 'c2jzsndq8brvn9fbckeec2'
          response = {
            "data": [
              {
                "id": "2",
                "type": "user",
                "attributes": {
                  "email": "jaime@dooley.co",
                  "google_id": "3lysgksxm233yx0bm45ju",
                  "google_image_url": "https://robohash.org/utestdolor.png?size=300x300&set=set1",
                  "zip_code": "14955",
                  "summary": "The secret to humor is surprise.",
                  "goal": "Gain Muscle",
                  "availability_morning": true,
                  "availability_afternoon": false,
                  "availability_evening": false,
                  "full_name": "Lamont Raynor II"
                }
              },
              {
                "id": "5",
                "type": "user",
                "attributes": {
                  "email": "ma_simonis@brekke.biz",
                  "google_id": "qn1loji9wdz4h02ccf6fn",
                  "google_image_url": "https://robohash.org/voluptatemfugaet.png?size=300x300&set=set1",
                  "zip_code": "13516",
                  "summary": "Beware the barrenness of a busy life.",
                  "goal": "Increase Flexibility",
                  "availability_morning": true,
                  "availability_afternoon": true,
                  "availability_evening": true,
                  "full_name": "Jerome Wunsch"
                }
              },
              {
                "id": "1",
                "type": "user",
                "attributes": {
                  "email": "tona.stark@klocko.info",
                  "google_id": "g94kqftp41tyi50sg42aa",
                  "google_image_url": "https://robohash.org/quiaetaspernatur.png?size=300x300&set=set1",
                  "zip_code": "41895",
                  "summary": "The virtue of justice consists in moderation, as regulated by wisdom.",
                  "goal": "Maintain Weight",
                  "availability_morning": false,
                  "availability_afternoon": false,
                  "availability_evening": false,
                  "full_name": "Joanne Champlin"
                }
              }
            ],
            "meta": {
              "gym_member_count": 3
            }
          }
          allow(GymService).to receive(:get_gym_users).with(yelp_gym_id).and_return(response)

          actual = GymFacade.get_gym_users(yelp_gym_id)
          expect(actual).to be_an(Array)
          expect(actual).to all(be_a(User))
        end
      end

      context 'when the gym has no members' do
        it 'returns an empty array' do
          yelp_gym_id = 'c2jzsndq8brvn9fbckeec2'
          response = {
              "data": [],
              "meta": {
                  "gym_member_count": 0
              }
          }
          allow(GymService).to receive(:get_gym_users).with(yelp_gym_id).and_return(response)

          expect(GymFacade.get_gym_users(yelp_gym_id)).to eq([])
        end
      end
    end
  end
end
