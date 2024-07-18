export const sendMessageToParent = (data, targetUrl) =>
    window.parent.postMessage({type: 'OUTPUT_DATA', data}, targetUrl);

export const setupMessageListener = targetUrl =>
    new Promise((resolve, reject) => {
        const handleMessage = event => {
            if (event.origin !== targetUrl) return;

            if (event.data.type === 'INPUT_DATA') resolve(event.data.data);
        };

        window.addEventListener('message', handleMessage);

        return () => {
            window.removeEventListener('message', handleMessage);
            reject(new Error('Message listener was removed'));
        };
    });
