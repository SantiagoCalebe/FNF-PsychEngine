package states;

import objects.AttachedSprite;
import sys;

class CreditsState extends MusicBeatState
{
	@@ -271,8 +272,56 @@ class CreditsState extends MusicBeatState
			}
			creditsStuff.push(['']);
		}

		catch(e:haxe.Exception) 
		{
  			trace('ERROR! ${e.message}');

    			var errorStr:String = e.message;
    			if (errorStr.contains("credits.txt") && !FileSystem.exists(Paths.mods("data/credits.txt"))) {
       			errorStr = "File: credits.txt wasn't found";
    			} else {
       			 errorStr += '\n\n' + e.stack;
    			}

    			missingText.text = "ERROR:\n$errorStr";
    			missingText.screenCenter(Y);
    			missingText.visible = true;
    			missingTextBG.visible = true;

    			var okButton:FlxText = new FlxText(0, missingText.y + missingText.height + 20, FlxG.width, "OK");
    			okButton.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
    			okButton.screenCenter(X);
    			okButton.alpha = 0.8;
    			okButton.color = FlxColor.GREEN;
    			okButton.onClick = function() {

        		FlxG.sound.play(Paths.sound('confirmMenu'));
        		missingText.visible = false;
        		missingTextBG.visible = false;
    		};

   		var openFolderButton:FlxText = new FlxText(0, okButton.y + okButton.height + 10, FlxG.width, "Open Folder.");
    		openFolderButton.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
    		openFolderButton.screenCenter(X);
    		openFolderButton.alpha = 0.8;
    		openFolderButton.color = FlxColor.YELLOW;
   		openFolderButton.onClick = function() {

        	FlxG.sound.play(Paths.sound('confirmMenu'));
        	Sys.openDirectory(Paths.mods("data"));
    		};

    	texts.add(okButton);
    	texts.add(openFolderButton);

    	FlxG.sound.play(Paths.sound('cancelMenu'));

    	updateTexts(elapsed);
    	super.update(elapsed);

    	return;
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
