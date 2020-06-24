'use strict';

module.exports = {
    '1 - Configure GNSS': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo /home/basegnss/rtkbase/tools/install.sh --detect-usb-gnss --configure-gnss',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '2 - Reboot': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo reboot',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
};

async function createDefaultMenu({path, data, DOM, CloudCmd}) {
    const {IO} = DOM;
    
    await IO.write(path, data);
    await CloudCmd.refresh();
    
    DOM.setCurrentByName('.cloudcmd.menu.js');
    
    await CloudCmd.EditFile.show();
}

async function readDefaultMenu({prefix}) {
    const res = await fetch(`${prefix}/api/v1/user-menu/default`);
    const data = await res.text();
    
    return data;
}

module.exports._selectNames = selectNames;
function selectNames(names, panel, {selectFile, getCurrentByName}) {
    for (const name of names) {
        const file = getCurrentByName(name, panel);
        selectFile(file);
    }
}

module.exports._compare = compare;
function compare(a, b) {
    const result = [];
    
    for (const el of a) {
        if (b.includes(el))
            continue;
        
        result.push(el);
    }
    
    return result;
}

