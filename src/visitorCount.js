export const incrementVisitorCount = async () => {
    try {
        const response = await fetch(
            "https://c1ohm28wsg.execute-api.ap-southeast-1.amazonaws.com/visitorCount",
            {
                method: "PATCH",
            }
        );

        if (!response.ok) {
            throw new Error(
                `Failed to update visitor count. Status code: ${response.status}`
            );
        }

        const json = await response.json();
        return json["VALUE"];
    } catch (err) {
        console.error(err.message);
    }
};
