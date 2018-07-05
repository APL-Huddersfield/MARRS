# MARRS (Microphone Array Recording and Reproduction Simulator)
(c) 2018 Applied Psychoacoustics Lab (APL), University of Huddersfield

Authors: Dr Hyunkook Lee, Dale Johnson and Maksims Mironovs
Correspondence to h.lee@hud.ac.uk

Developed based on a novel psychoacoustic time-level trade-off algorithm, MARRS provides an interactive, object-based workflow and graphical user interface for localisation prediction and microphone array configuration. It allows the user to predict the perceived positions of multiple sound sources for a given microphone configuration. The tool can also automatically configure suitable microphone arrays for the user’s desired spatial scene in reproduction. Furthermore, MARRS overcomes some of the limitations of existing microphone array simulation tools by taking into account microphone height and vertical orientations as well as the target loudspeaker base angle. 

# References

[1] H. Lee, D. Johnson, and M. Mironovs, “An Interactive and Intelligent Tool for Microphone Array Design,” presented at the 143rd Convention of the Audio Engineering Society (2017 Oct), e-brief 390.

[2] H. Lee and F. Rumsey, “Level and time panning of phantom images for musical sources,” J. Audio Eng. Soc., vol. 61 (12), pp. 753–767 (2013 Dec.). 

# Matlab codes
Matlab codes for calculating perceived image angle are available here.

marrs(): the main function that calculates Iterchannel Time Difference (ICTD) and Interchannel Level Difference (ICLD), and calls angleCalc() to return the predicted perceived image angle.
Inputs: mic spacing, mic angle, source-mic distance, source height, mic height, mic tilt, speaker angle. 
Outputs: perceived image angle, Iterchannel Time Difference (ICTD), Interchannel Level Difference (ICLD)

angleCalc(): this function predicts perceived image angle between two loudspeakers for given ICTD and ICLD, based on the ICTD and ICLD trade-off method proposed in [1].

polarMagnitude(): this function calculates the polar response for a given source-microphone angle and distance.

# App 
The iOS and Android app versions of MARRS can be freely downloaded from the links below.

Android: https://play.google.com/store/apps/details?id=com.apl.marrs&hl=en_GB

iOS: https://itunes.apple.com/app/id1295926126

