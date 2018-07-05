% MARRS (Microphone Array Recording and Reproduction Simulator)
%
% Function: marrs(spacing, subtendedAngle, sourceToMicStand, sourceHeight, 
%             micHeight, micTilt, polarPattern, sourceAngle)
%
% Authors: Dale Johnson and Hyunkook Lee (c) 2018
%          dale.johnson@hud.ac.uk   h.lee@hud.ac.uk
%          Applied Psychoacoustics Lab (APL)
%          University of Huddersfield, UK.
%
% This function calculates the ICLD and ICTD between two microphones and 
% the resultant perceived image angle in stereo reproduciton.
%
% Reference:
% H. Lee, D. Johnson, and M. Mironovs, "An Interactive and Intelligent Tool
% for Microphone Array Design," presented at the 143rd Convention of the 
% Audio Engineering Society (2017 Oct), e-brief 390.
% (MARRS app for iOS and Android available for free download)
%
% Input parameters:
% spacing = microphone spacing (metres)
% subtendedAngle = microphone angle (degrees)
% sourceToMicStand = 2D distance from mic stand base to source base (metres)
% sourceHeight = height of actual sound source from floor (metres)
% micHeight = height of mic array from the floor (metres)
% micTilt = vertical rotation of the microphones. 0 is straight ahead, 
%                +ve angle is rotation towards the ceiling, and 
%                -ve angle is rotation towards the floor (degrees)
% polarPattern = polar pattern p value (0.0 = Fig-of-8, 0.5 = cardioid, 
%                1.0 = omni)
% sourceAngle = Topdown 2D azimuth angle the source is from mic stand (degrees)
%
% Output values:
% imgAngle (degrees)
% ICTD (ms)
% ICLD (dB)
%%

function out = marrs(spacing, subtendedAngle, sourceToMicStand,...
    sourceHeight, micHeight, micTilt, polarPattern, sourceAngle, speakerAngle)
sourceAngle = sourceAngle / 180 * pi;
micAngle = subtendedAngle / 180 * pi * 0.5;
micTilt = micTilt / 180 * pi;

%% Turn distances and angles into vectors
sourcePos = [sin(sourceAngle), 0.0 , cos(sourceAngle)] * sourceToMicStand;
sourcePos(2) = sourceHeight;
micAPos = [-spacing / 2.0, micHeight, 0.0];
micBPos = [spacing / 2.0, micHeight, 0.0];
angle = atan(micHeight/sourceToMicStand) * -1.0; % / 3.14159 * 180;
micANormal = [sin(-micAngle), 0.0, cos(-micAngle)];
micBNormal = [sin(micAngle), 0.0, cos(micAngle)];

R = [1, 0, 0; 0, cos(micTilt), -sin(micTilt); 0, sin(micTilt), cos(micTilt)];
    
micANormal = micANormal * R;
micBNormal = micBNormal * R;

%% Find distance to source and microphones, then calculate normals
deltaA = sourcePos - micAPos;
deltaB = sourcePos - micBPos;
distA = sqrt(sum(deltaA .* deltaA));
distB = sqrt(sum(deltaB .* deltaB));
micToSourceNormA = deltaA / distA;
micToSourceNormB = deltaB / distB;

%% Calculate time and level differences
ICTD = (distA - distB) / .34029;
micALevel = polarMagnitude(micToSourceNormA, micANormal, polarPattern);
micBLevel = polarMagnitude(micToSourceNormB, micBNormal, polarPattern);
ICLD = 20.0 * log10(micALevel / micBLevel);
    
%% Calculate perceived image angle
imgAngle = angleCalc(sourceAngle,speakerAngle,ICTD, ICLD);

out = [imgAngle; ICTD; ICLD];