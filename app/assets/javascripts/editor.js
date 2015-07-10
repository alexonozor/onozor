$(document).ready(function() {
    $('#add_h1').on("click", function(e) {
        e.preventDefault();
        md_insert_h1_to('question[body]');
    });

    $('#add_h2').on("click", function(e) {
        e.preventDefault();
        md_insert_h2_to('question[body]');
    });

    $('#add_h3').on("click", function(e) {
        e.preventDefault();
        md_insert_h3_to('question[body]');
    });

    $('#add_h4').on("click", function(e) {
        e.preventDefault();
        md_insert_h4_to('question[body]');
    });

    $('#add_h5').on("click", function(e) {
        e.preventDefault();
        md_insert_h5_to('question[body]');
    });

    $('#add_h6').on("click", function(e) {
        e.preventDefault();
        md_insert_h6_to('question[body]');
    });

    $('#add_em').on("click", function(e) {
        e.preventDefault();
        md_insert_em_to('question[body]');
    });

    $('#add_strong').on("click", function(e) {
        e.preventDefault();
        md_insert_strong_to('question[body]');
    });

    $('#add_paragraph').on("click", function(e) {
        e.preventDefault();
        md_insert_paragraph_to('question[body]');
    });

    $('#add_blockquote').on("click", function(e) {
        e.preventDefault();
        md_insert_blockquote_to('question[body]');
    });

    $('#add_unord_list').on("click", function(e) {
        e.preventDefault();
        md_insert_unord_list_to('question[body]');
    });

    $('#add_ord_list').on("click", function(e) {
        e.preventDefault();
        md_insert_ord_list_to('question[body]');
    });

    $('#add_link').on("click", function(e) {
        e.preventDefault();
        md_insert_link_to('question[body]');
        alert("welcme");
    });

    $('#insert_code').on("click", function(e) {
        e.preventDefault();
        md_insert_code_to('question[body]');
    });
});

function md_insert_link_to(element) {
    insertText(element, "[", "](http://link_address)", "link_name")
}

function md_insert_h1_to(element) {
    insertText(element, "\n# ", "\n", "H1")
}

function md_insert_h2_to(element) {
    insertText(element, "\n## ", "\n", "H2")
}

function md_insert_h3_to(element) {
    insertText(element, "\n### ", "\n", "H3")
}


function md_insert_em_to(element) {
    insertText(element, "*", "*", "italic")
}

function md_insert_strong_to(element) {
    insertText(element, "**", "**", "bold")
}

function md_insert_code_to(element) {
    insertText(element, "```", "```", "code")
}

function md_insert_paragraph_to(element) {
    insertText(element, "\n", "\n\n", "paragraph")
}

function md_insert_blockquote_to(element) {
    insertText(element, "\n> ", "\n", "blockquote")
}

function md_insert_unord_list_to(element) {
    insertText(element, "\n* ", "\n", "element")
}

function md_insert_ord_list_to(element) {
    insertText(element, "\n1 ", "\n", "element")
}




function insertText(element_name, before_text, after_text, default_text) {
    // get element by name
    var element = document.getElementsByName(element_name)[0];

    //IE specific patch: IE 9 etc.
    if (selection = document.selection) {
        IE_insertText(element, selection, before_text, after_text, default_text);
        //modern browsers
    } else if (element.selectionStart || element.selectionStart == '0') {
        var selection_from       = element.selectionStart;
        var selection_to         = element.selectionEnd;
        var val                  = element.value;
        var text_before_selected = val.substring(0, selection_from);
        var text_after_selected  = val.substring(selection_to, val.length);
        var selected_text        = val.substring(selection_from, selection_to);
        var content;

        // if we didn't select anything we add default text
        if (selection_from == selection_to) {
            content = default_text;
            // otherwise we use selected text
        } else {
            content = selected_text;
        }

        // updating element value
        element.value = text_before_selected + before_text + content +
            after_text + text_after_selected;
        element.focus();

        // do highlight text
        element.selectionStart = selection_from + before_text.length;
        element.selectionEnd   = element.selectionStart + content.length;

        if (selection_from != selection_to) {
            window.getSelection().collapseToEnd();
        }
        //other ones?
    } else {
        alert("still not fully implemented");
    }
}