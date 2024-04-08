import globals from "globals";

export default [
    {
        files: ["**/*.js"],
        languageOptions: {
            globals: {
                ...globals.browser,
                myCustomGlobal: "readonly"
            }
        },
        rules: {
            "no-unused-vars": "error",
            "no-console": "off"
        }
    }
];
