require 'flexgen/metamodel_builder'

module HouseMetamodel
   extend FlexGen::MetamodelBuilder::ModuleExtension
   include FlexGen::MetamodelBuilder::DataTypes

   SexEnum = Enum.new(:name => 'SexEnum', :literals =>[ :male, :female ])

   class House < FlexGen::MetamodelBuilder::MMBase
      annotation :source => "bla", :details => {'a' => 'b'}
      has_attr 'address', String, :changeable => false 
   end

   class MeetingPlace < FlexGen::MetamodelBuilder::MMBase
   end

   class Person < FlexGen::MetamodelBuilder::MMBase
      has_attr 'sex', HouseMetamodel::SexEnum 
   end


   module Rooms
      extend FlexGen::MetamodelBuilder::ModuleExtension
      include FlexGen::MetamodelBuilder::DataTypes


      class Room < FlexGen::MetamodelBuilder::MMBase
      end

      class Bathroom < Room
      end

      class Kitchen < FlexGen::MetamodelBuilder::MMMultiple(Room, HouseMetamodel::MeetingPlace)
      end

   end
end

HouseMetamodel::House.has_one 'bathroom', HouseMetamodel::Rooms::Bathroom, :lowerBound => 1 
HouseMetamodel::House.one_to_one 'kitchen', HouseMetamodel::Rooms::Kitchen, 'house', :lowerBound => 1 
HouseMetamodel::House.contains_many 'room', HouseMetamodel::Rooms::Room, 'house' 
HouseMetamodel::Person.has_many 'house', HouseMetamodel::House 
