function struct2txt(strct, filename, delimiter)
% struct2txt writes a .csv file from a structure.
%
% It assumes all fields of the structure are the same length, character
% arrays should be the same length in the first dimension.
%
% struct2txt(txt2struct(infile),outfile) should create outfile identical to
% infile.
%
%   Inputs:
%       strct       struct to output (mandatory)
%       filename    file to write (user will be asked if not provided)
%       delimiter   field seperator [,]
%
%   Outputs:
%       The file specified by filename will be written

% Gordon Keith 20130910

if nargin < 1 || ~isstruct(strct)
    Error('Usage struct2txt(structure, filename, delimiter');
end

if nargin < 2 
    filename = '';
end
if isempty(filename) || exist(filename,'dir') == 7
    [file, path] = uiputfile(fullfile(filename, 'File to save', '*.csv'));
    filename = fullfile(path,file);
end

if nargin < 3
    delimiter = ',';
end

% write file

fid = fopen(filename,'w');
if fid < 0
    Error(['Unable to open: ' filename]);
end

fnames = fieldnames(strct);
fn = length(fnames);

% write header line

for f = 1:fn
    fprintf(fid,'%s',fnames{f});
    if f < fn
        fprintf(fid,'%s',delimiter);
    else
        fprintf(fid,'\n');
    end
end

% write data

n = size(strct.(fnames{1}),1);

for i = 1:n
    for f = 1:fn
        if iscell(strct.(fnames{f}))
            fprintf(fid,'%s',strct.(fnames{f}){i});
        elseif ischar(strct.(fnames{f}))
            fprintf(fid,'%s',strct.(fnames{f})(i,:));
        else
            %fprintf(fid,'%.9g',strct.(fnames{f})(i)); 
            %replaced with %f.
            fprintf(fid,'%f',strct.(fnames{f})(i));
            
        end
        if f < fn
            fprintf(fid,'%s',delimiter);
        else
            fprintf(fid,'\n');
        end
    end
end

fclose(fid);
