% MARRS (Microphone Array Recording and Reproduction Simulator) %
%
% Function: angleCalc(sourceAngle, speakerAngle, ICTD, ICLD) 
%
% Authors: Hyunkook Lee (c) 2018
%          h.lee@hud.ac.uk
%          Applied Psychoacoustics Lab (APL)
%          University of Huddersfield, UK.
%
% This function predicts perceived image angle between two loudspeakers 
% for given ICTD and ICLD, based on the ICTD and ICLD trade-off method proposed in 
%
% Reference:
% H. Lee, D. Johnson, and M. Mironovs, "An Interactive and Intelligent Tool
% for Microphone Array Design," presented at the 143rd Convention of the 
% Audio Engineering Society (2017 Oct), e-brief 390.
% (MARRS app for iOS and Android available for free download)
%
% Input arguments:
% sourceAngle = azimuth of sound source in degree
% speakerAngle = azimuth of loudspeaker in degree (half the loudspeaker base angle)
% ICTD = Interchannel time difference in ms
% ICLD = Interchannel time difference in dB
%
% Output: Predicted perceived angle in degree


function out = angleCalc(sourceAngle,speakerAngle,ICTD, ICLD)

ICLD = abs(ICLD);
ICTD = abs(ICTD);
    
theta = speakerAngle; %half the base angle (e.g. 45 for 90deg speaker setup)

%% Loudspeaker base angle adaptive ICTD and ICLD scaling
% 30 and 45 degrees for now, to be extended for other angles in the future.
if theta == 30
    a = 1;
    b = 1;
elseif theta == 45
    a = 1.5;
    b = 1.3;
end

% a, b = ICTD and ICLD scale factors
% a = ITD(theta)/ITD(30), b = ILD(theta)/ILD(30)


%% Predict perceived image azimuth (deg)

% Region adaptive trade-off function
if ICTD <= (-(a/(17*b))*ICLD+(a/2)) && ICLD <= ((17*b)*((a/2)-ICTD)) 
    angle = (ICTD+(a/(17*b))*ICLD)*((4*theta)/(3*a)); % within 2/3 shift region
else
    angle = (ICTD+(a/(17*b))*ICLD+(a/2))*((2*theta)/(3*a)); % outside 2/3 region
end

% Limit the perceived angle to 100% shift point (speaker angle) 
if angle > theta
    angle = theta;
elseif angle < -theta
    angle = -theta;
end

if sourceAngle < 0
    out = -angle;
else 
    out = angle;
end

