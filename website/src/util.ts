import { NamedColours } from "./colours";
import { NamedColour } from "./types";

const formatReplacer = (
    _match: string,
    p1: string,
    _offset: number,
    _string: string,
    _groups: any
) => {
    const classes = p1.split(",");
    let css_styling = "";

    for (const currentClass of classes) {
        const parts = currentClass.split(":");
        const colour =
            NamedColours[parts[1].toUpperCase() as NamedColour] ?? "#000000";

        if (parts[0] == "C") {
            css_styling += `color: ${colour};`;
        } else if (parts[0] == "X") {
            css_styling += `background-color: ${colour}; border-radius: 5px; padding: 0 2px 0 4px;`;
        }
    }

    return `</span><span style="${css_styling}">`;
};

const regex = /{([^}]+)}/g;
export const formatDescription = (text: string[]) => {
    return text.map((line) =>
        (line + "{}").replaceAll("{}", "</span>").replace(regex, formatReplacer)
    );
};
