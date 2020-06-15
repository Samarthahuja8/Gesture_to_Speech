%userPrompt = 'What do you want the computer to say?';
%titleBar = 'Text to Speech';
%defaultString = 'Hello World!  MATLAB is an awesome program!';
%caUserInput = inputdlg('Hello', titleBar, 1, {defaultString});
%if isempty(caUserInput)
 % return;
%end; % Bail out if they clicked Cancel.
caUserInput = char('Hello Niro How Are You'); % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, caUserInput);