function varargout = matlabpong(varargin)
% MATLABPONG MATLAB code for matlabpong.fig
%      MATLABPONG, by itself, creates a new MATLABPONG or raises the existing
%      singleton*.
%
%      H = MATLABPONG returns the handle to a new MATLABPONG or the handle to
%      the existing singleton*.
%
%      MATLABPONG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATLABPONG.M with the given input arguments.
%
%      MATLABPONG('Property','Value',...) creates a new MATLABPONG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matlabpong_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matlabpong_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matlabpong

% Last Modified by GUIDE v2.5 21-Nov-2024 14:04:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matlabpong_OpeningFcn, ...
                   'gui_OutputFcn',  @matlabpong_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before matlabpong is made visible.
function matlabpong_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matlabpong (see VARARGIN)

% Choose default command line output for matlabpong
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.plTitle, 'units', 'normalized', 'position', [0 0.85 1 0.15]);
set(handles.axCanvas, 'xlim', [0,1], 'ylim', [0,1], 'xtick', [], 'ytick', [], ...
    'units', 'normalized', 'position', [0.02 0.02 0.96 0.8]);
axis(handles.axCanvas, 'on');
box(handles.axCanvas, 'on');

set(handles.txRedScore, 'foregroundcolor', 'r')
set(handles.txBlueScore, 'foregroundcolor', 'b')

uidata=get(handles.fmMain, 'userdata');

delete(timerfindall)

uidata.timer=timer('TimerFcn', @updatepong);
uidata.timer.userData=struct('handles', handles, 'timerdata', struct());
uidata.timer.Period=(1/get(handles.sbSpeed, 'value'));
uidata.timer.ExecutionMode  = 'fixedRate';

set(handles.fmMain, 'userdata', uidata);

% UIWAIT makes matlabpong wait for user response (see UIRESUME)
% uiwait(handles.fmMain);


% --- Outputs from this function are returned to the command line.
function varargout = matlabpong_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btStart.
function btStart_Callback(hObject, eventdata, handles)
% hObject    handle to btStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axCanvas);
hold(handles.axCanvas, 'on');

hpong=plot(0.5, 0.5, 'ro', 'markersize', 8, 'parent', handles.axCanvas);
y1=rand(1)*0.8;
y2=rand(1)*0.8;
hredbat=plot([0 0], [y1 y1+0.2], 'r-', 'linewidth', 8, 'parent', handles.axCanvas);
hbluebat=plot([1 1], [y2 y2+0.2], 'b-', 'linewidth', 8, 'parent', handles.axCanvas);

uidata=get(handles.fmMain, 'userdata');

timerdata=get(uidata.timer, 'userdata');
timerdata.pong = hpong;        % this is the handle to the pingpong dot object
timerdata.redbat = hredbat;    % this is the handle to the red-bat line object
timerdata.bluebat = hbluebat;  % this is the handle to the blue-bat line object
timerdata.dir = rand(1,2) * 2 - 1;     % this is a random direction
timerdata.dir = timerdata.dir / norm(timerdata.dir);

timerdata.userdata = handles;
set(uidata.timer, 'userdata', timerdata);
set(handles.fmMain, 'userdata', uidata);

start(uidata.timer);

% --- Executes on button press in btStop.
function btStop_Callback(hObject, eventdata, handles)
% hObject    handle to btStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uidata=get(handles.fmMain, 'userdata');
stop(uidata.timer);


% --- Executes during object creation, after setting all properties.
function sbSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sbSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object deletion, before destroying properties.
function fmMain_DeleteFcn(hObject, eventdata, handles)
uidata = get(handles.fmMain, 'userdata');
stop(uidata.timer)

%%  Your work is mostly focused on completing the functions below


% --- Executes on slider movement.
function sbSpeed_Callback(hObject, eventdata, handles)
%% TODO: when this slider bar changes, you should set the timer's period accordingly
% timer's period = (1/get(handles.sbSpeed, 'value'))
    speedValue = get(hObject, 'Value');
    
    newPeriod = (1 / speedValue);
    uidata = get(handles.fmMain, 'userdata');
    set(uidata.timer, 'Period', newPeriod);
    set(handles.fmMain, 'userdata', uidata);


%uidata = get(handles.fmMain, 'userdata');
get(uidata.timer, 'Period');
get(handles.sbSpeed, 'value');

% --- Executes on button press in btClose.
function btClose_Callback(hObject, eventdata, handles)
%% TODO: write this function to 1) stop the timer, 
% which is uidata=get(handles.fmMain, 'userdata'); uidata.timer
% and 2) close this window

  uidata = get(handles.fmMain, 'userdata');
  stop(uidata.timer);
  close(handles.fmMain);


function updatepong(timerobj, event)
%% TODO: please write this timer event function to move the pingpong ball
% this timer event function will be triggered periodically
% you should use this function to 
%  - update the pingpong ball's position:
%  - always reflect at the top/bottom edges, and 
%  - on the left-right edges, reflect if hits the red/blue bat (each is 0.2 tall)
%  - if exiting from the left/right edges, if on the left side, increase blue
%    team's score (handles.txRedScore) by 1; if exit from the right side, increase red
%    team's score (handles.txBlueScore) by 1; then relaunch from the center
%    at a random angle.

%disp('updatepong function executed');
timerdata = get(timerobj, 'userdata');
handles = timerobj.UserData;


ball_x = get(timerdata.pong, 'xdata');    % use timer.pong to get its x/y data
ball_y = get(timerdata.pong, 'ydata');             % use timer.redbat/timer.bluebat to get their ydata
dir = timerdata.dir;                              % this is the current direction, need to modify it if reflected
dx = timerdata.dir(1);
dy = timerdata.dir(2);
new_x = ball_x + dx * 0.01; % step size 0.01
new_y = ball_y + dy * 0.01;

    % Reflection at top/bottom edges
    if new_y < 0 || new_y > 1
        dy = -dy; % Reflect direction
        if new_y < 0
            new_y = 0; % Ensure position doesn't go out of bounds
        else
            new_y = 1;
        end
    end
    
    % Reflection at left/right edges with bat collision
    if new_x < 0 % Left edge
        yBat = get(timerdata.redbat, 'ydata');
        if ball_y + 0.05 > yBat(1) && ball_y - 0.05 < yBat(2) % Assuming ball size of 0.1
            dx = -dx; % Reflect direction
            new_x = 0; % Ensure position doesn't go out of bounds
        else
            % Increase blue team's score and relaunch from center
            blueScore = str2double(get(timerdata.txBlueScore, 'String'));
            blueScore = blueScore + 1;
            set(timerdata.txBlueScore, 'String', num2str(blueScore));
            new_x = 0.5; new_y = 0.5;
            dx = rand(1) * 2 - 1; dy = rand(1) * 2 - 1;
            [dx, dy] = normalize([dx, dy]);
        end
    elseif new_x > 1 % Right edge
        yBat = get(timerdata.bluebat, 'ydata');
        if ball_y + 0.05 > yBat(1) && ball_y - 0.05 < yBat(2)
            dx = -dx; % Reflect direction
            new_x = 1; % Ensure position doesn't go out of bounds
        else
            % Increase red team's score and relaunch from center
            redScore = str2double(get(timerdata.txRedScore, 'String'));
            redScore = redScore + 1;
            set(timerdata.txRedScore, 'String', num2str(redScore));
            new_x = 0.5; new_y = 0.5;
            dx = rand(1) * 2 - 1; dy = rand(1) * 2 - 1;
            [dx, dy] = [dx, dy] / norm([dx, dy]);
        end
    end

    % Update ball position
    set(timerdata.pong, 'xdata', new_x, 'ydata', new_y);
    
    % Update direction in timerdata
    timerdata.dir = [dx, dy];

% use these variables to move the pingpong or changing direction, or
% restart the game

get(timerdata.pong, {'xdata', 'ydata'});    % use timer.pong to get its x/y data
get(timerdata.redbat, 'ydata');             % use timer.redbat/timer.bluebat to get their ydata


% at the end of the function, save the updated timerdata to timerobj.userdata
set(timerobj, 'userdata', timerdata);

% --- Executes on key press with focus on fmMain or any of its controls.
function fmMain_WindowKeyPressFcn(hObject, eventdata, handles)
%% TODO: write this function to move the two red/blue bats up and down 
%using eventdata.Key to decide what key is pressed, and increment/decrement
%the ydata of the two bats (uidata.redbat)

uidata = get(handles.fmMain, 'userdata');
timerdata = get(uidata.timer, 'userdata');

switch eventdata.Key
  case 's' % red up
    yBat = get(timerdata.redbat, 'ydata');
    if yBat(1) > 0
      set(timerdata.redbat, 'ydata', [yBat(1)-0.1, yBat(2)-0.1]);
    end
  case 'w' % red down
    yBat = get(timerdata.redbat, 'ydata');
    if yBat(2) < 1
      set(timerdata.redbat, 'ydata', [yBat(1)+0.1, yBat(2)+0.1]);
    end
  case 'k' % blue up
    yBat = get(timerdata.bluebat, 'ydata');
    if yBat(1) > 0
      set(timerdata.bluebat, 'ydata', [yBat(1)-0.1, yBat(2)-0.1]);
    end
  case 'o' % blue down
    yBat = get(timerdata.bluebat, 'ydata');
    if yBat(2) < 1
      set(timerdata.bluebat, 'ydata', [yBat(1)+0.1, yBat(2)+0.1]);
    end
end
  set(uidata.timer, 'userdata', timerdata);
  set(uidata.timer, 'userdata', timerdata);
  set(handles.fmMain, 'userdata', uidata);

      disp(eventdata.Key);             % the keystroke that triggers this event
      get(timerdata.redbat, 'ydata');  % the y-positions of the red-bat
      get(timerdata.bluebat, 'ydata'); % same for the blue-bat; bat length should always 0.2