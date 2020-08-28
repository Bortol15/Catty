# Implementation of landscape mode for Catty #

I participated in the Google Summer of Code 2020 to help the Catrobat organisation
to implement the landscape mode in Catty, the iOS Version of Pocket Code. The main goal
was to enable the user to choose in which orientation he or she wants to code and expand the
possibilities within Pocket Code.

# About my work #

## Analyzing Catroid &emsp;&emsp;       State: DONE ##
In the very beginning, the main focus was on understanding and documenting the landscape behavior of Catroid, the Android Version of Pocket Code. That was an important cornerstone because the landscape mode in Catty should work similar to the landscape mode in Catroid.
From this step I also got to know which sensors need special treatment. These Sensors are <AccelerationXSensor.swift> ,
<AccelerationYSensor.swift>, <InclinationXSensor.swift>, <InclinationYSensor.swift> and <CompassDirectionSensor.swift>.

## Implementation of the landscape Bool into the datastructure &emsp;&emsp;       State: DONE ##
Here is the PR to the following: https://github.com/Catrobat/Catty/pull/1395

To enable the modification of the sensors and the scene and to enable the user the chose which orientation he or she
would like to use a landscape Bool had to be implemented in the datastructure. This caused massive changes in the datastructure.
I was lucky that the Serializer&Parser where perfectly prepared so I just had to "connect" them to my implementation.
And of course, as the whole projects workflow is test driven, a lot of Unit Tests were added.

## Modification of the Sensors  &emsp;&emsp;                                 State: DONE ##
Here are the PR's to the following: https://github.com/Catrobat/Catty/pull/1403 , https://github.com/Catrobat/Catty/pull/1406,
https://github.com/Catrobat/Catty/pull/1420

For the Accerleration and Inclination Sensors the values of opposite sensors are used if the landscape mode is chosen.
So for example, the <AccelerationXSensor.swift> uses the Value of the Y Sensor if the landscape mode is chosen
and vice versa. And of course, a lot of Unit Tests were added.

## Change evaluation of Sensors and fix Bugs &emsp;&emsp;       State: DONE ##
Here are the PR's to the following: https://github.com/Catrobat/Catty/pull/1407, https://github.com/Catrobat/Catty/pull/1425,
https://github.com/Catrobat/Catty/pull/1462

On suggestions of a member of the Catrobat team the evaluation of the sensors got changed to reduce the complexity.
Also the behavior if the sensors are not available got changed, the X and Y Sensors used the same standard path to
ensure the correct behavior. While testing the Sensor behavior some bugs came up which were fixed in another PR.

## Modify the Scene Presenter for the landscape Mode   &emsp;&emsp;      State: DONE ##
Here are the PR's to the following: https://github.com/Catrobat/Catty/pull/1455, https://github.com/Catrobat/Catty/pull/1456

The Scene Presenter had to be modified to change it's orientation depending on the users choice. The orientation get's forced
and set before the scene itself gets presented. Also the menuView and gridView had to be changed to ensure correct behavior.
And of course, a lot of Unit Tests were added.

## Enable the User to chose the projects orientation  &emsp;&emsp;       State: In developement ##
The User will be enabled to change the orientation using the edit section of the ProjectTableViewController.
The ticket is in the final phase and currently bugs get fixed.

# Conclusion about my GSoC #
GSoC was a great experience for me. I learned several important things. Beside the developement skills itself I learned how
to work in a big project with a whole lot of people. I'd like to thank everybody who supported me throughout the summer,
it was a great experience for me!
