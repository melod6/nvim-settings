return {
    cmd = { '/path/to/ols' },
    filetypes = { 'odin' },
    root_markers = { 'ols.json', '.git' },
    settings = {
        odin_path = "/path/to/Odin",
        checker_args = '-strict-style',
        enable_hover = true,
        enable_snippets = true,
        enable_document_symbols = true,
        enable_format = true,
        collections = {
            { name = "core", path = "/path/to/Odin/core" },
            { name = "vendor", path = "/path/to/Odin/vendor" },
        },
    },
}
