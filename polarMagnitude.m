% MARRS (Microphone Array Recording and Reproduction Simulator)
%
% Function: polarMagnitude(micToSourceNormal, micNormal, patternCoeff)
%
% Authors: Dale Johnson and Hyunkook Lee (c) 2018
%          dale.johnson@hud.ac.uk   h.lee@hud.ac.uk
%          Applied Psychoacoustics Lab (APL)
%          University of Huddersfield, UK.
%
% This function calculates polar magnitude for source-mic angle and
% distance
%

function out = polarMagnitude(micToSourceNormal, micNormal, patternCoeff)

out = patternCoeff + (1.0 - patternCoeff) * dot(micNormal, micToSourceNormal);
