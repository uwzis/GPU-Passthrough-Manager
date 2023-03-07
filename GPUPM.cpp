#include <iostream>
#include <gtk-3.0/gtk/gtk.h>
#include <fstream>
#include <json/json.h>
#include <json/value.h>

using namespace std;
//RUN AS ROOT
void returns(){
    exit(0);
}
void settings(GtkWidget *settingsMan, gpointer data) {
    system("./tools/Settings");
}
// Run first time set up scripts
void first(GtkWidget *payload, gpointer data){
    system("sh ./tools/fts.sh"); // Run first time setup script
    system("touch ./data.json && ./tools/Reboot");
}

//Load VFIO drivers
void vfiod(GtkWidget *vfio, gpointer data) {
    system("sh ./tools/vfiomgr.sh && ./tools/Reboot"); // Run VFIO driver script
}

// Load Default drivers
void defaultd(GtkWidget *calculate, gpointer data) {
    system("sh ./tools/defaultmgr.sh && ./tools/Reboot"); // Run default GPU driver script
}

// Load CSS for GTK
static void load_css ( void ){
    GtkCssProvider *provider;
    GdkDisplay *display;
    GdkScreen *screen;

    const gchar *css_style_file = "./style.css";
    GFile *css_fp               = g_file_new_for_path ( css_style_file );
    GError *error               = 0;

    provider = gtk_css_provider_new ();
    display = gdk_display_get_default ();
    screen  = gdk_display_get_default_screen ( display );

    gtk_style_context_add_provider_for_screen (screen, GTK_STYLE_PROVIDER ( provider ), GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
    gtk_css_provider_load_from_file ( provider, css_fp, &error);

    g_object_unref ( provider );
}

static void check_state(GtkWidget* widget, gpointer data, int argc, char **argv) {
    int i = *(int *)data;
    ifstream file("./data.json");// Get the state Json data
    Json::Value son;
    Json::Reader reader;
    reader.parse(file, son);
    file.close();
    g_print("button%i, ", i+1);// list button number then command ran
    string id = son["devices"][i]["id"].asString();
    if(gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget))){//write to file
        char cmd[50];
        string str = "python3 ./py/confmgr.py ./vfio.conf add ";
        str = str + id;
        const char *exe = str.c_str();
        system(exe);
    }else{//delete from file
        char md[50];
        string tr = "python3 ./py/confmgr.py ./vfio.conf remove ";
        tr = tr + id;
        const char *rm = tr.c_str();
        system(rm);
    }
}

//g++ ./GPUPM.cpp -o "GPUPM" `pkg-config --cflags --libs jsoncpp  gtk+-3.0`
int main(int argc, char **argv) {
    //if json file does not exist, then run first time startup
int checkIfFileExists(const char *filename);
    if (geteuid() == 0) {
        if( access("./data.json", F_OK ) != -1){
            system("python ./py/load.py");
            //initiate gtk widgets
            GtkWidget *window, *grid, *para, *default1, *vfio, *vbox, *label, *text, *settingsMan;
            GdkPixbuf *pixbuf;
            gtk_init(&argc, &argv);
            load_css();
            //create window
            window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
                gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
                g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
            //icon 
            pixbuf = gdk_pixbuf_new_from_file("./icons/GPUPM.png", NULL);
                gtk_window_set_icon(GTK_WINDOW(window), pixbuf);
            //create container
            vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
                gtk_container_add(GTK_CONTAINER(window), vbox);
            // Title


            label = gtk_label_new_with_mnemonic("null");
                gtk_label_set_markup (GTK_LABEL (label), "<span font='18'><b>Welcome to GPU Passthrough Manager\n</b></span>");
                gtk_container_add(GTK_CONTAINER(vbox), label);
                gtk_box_pack_start(GTK_BOX(vbox), label, 0,1,1);
                gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
            //info
            para = gtk_label_new_with_mnemonic("null");
                gtk_label_set_markup (GTK_LABEL (para), "<span font='12'>Select devices to load vfio drivers. Or load default drivers</span>");
                gtk_container_add(GTK_CONTAINER(vbox), para);
                gtk_box_pack_start(GTK_BOX(vbox), para, 0,1,1);
                gtk_label_set_justify(GTK_LABEL(para), GTK_JUSTIFY_CENTER);
            //cature json data
            ifstream file("./data.json");
            Json::Value actualJson; 
            Json::Reader reader;
            reader.parse(file, actualJson);
            file.close();
            //itterate buttons for the length of the devices in data.json   
                  
            if (actualJson["devices"].size() > 0){
                GtkWidget *scroll, *boxy;
                    scroll = gtk_scrolled_window_new(NULL, NULL);
                    gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scroll), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
                    gtk_container_add(GTK_CONTAINER(vbox), scroll);
                    boxy = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
                    gtk_container_add(GTK_CONTAINER(scroll), boxy);
                    //size of scroll
                    gtk_widget_set_size_request(scroll, 400, 330);

                for (int i = 0; i < actualJson["devices"].size(); i++) {
                    GtkWidget *toggle[i];

                    toggle[i] = gtk_toggle_button_new_with_label(actualJson["devices"][i]["name"].asString().c_str());
                    gtk_box_pack_start(GTK_BOX(boxy), toggle[i], 0,1,1);
                    int* idx = new int;
                    *idx = i;
                    g_signal_connect_data(toggle[i], "toggled", G_CALLBACK(check_state), (gpointer*) idx, (GClosureNotify)free, (GConnectFlags) 0);
                    g_print("device %i button created\n", i + 1);
                    }
                }else{
                    for (int i = 0; i < actualJson["devices"].size(); i++) {
                    GtkWidget *toggle[i];
                    toggle[i] = gtk_toggle_button_new_with_label(actualJson["devices"][i]["name"].asString().c_str());
                    gtk_box_pack_start(GTK_BOX(vbox), toggle[i], 0,1,1);
                    int* idx = new int;
                    *idx = i;
                    g_signal_connect_data(toggle[i], "toggled", G_CALLBACK(check_state), (gpointer*) idx, (GClosureNotify)free, (GConnectFlags) 0);
                    g_print("device %i button created\n", i + 1);
                }   
            }

            //makes grid for buttons Load Default and Load VFIO
            grid = gtk_fixed_new();
                gtk_container_add(GTK_CONTAINER(vbox), grid);
            // Load Default
            default1 = gtk_button_new_with_label("Load Default");
                g_signal_connect(default1, "clicked", G_CALLBACK(defaultd), NULL);
                gtk_fixed_put(GTK_FIXED(grid), default1, 0, 300);
                gtk_widget_set_size_request(default1, 250, 30);
            // Load VFIO
            vfio = gtk_button_new_with_label("Load VFIO");
                g_signal_connect(vfio, "clicked", G_CALLBACK(vfiod), NULL);
                gtk_fixed_put(GTK_FIXED(grid), vfio, 400, 300);
            //get window resloution at runtime



                gtk_widget_set_size_request(vfio, 250, 30);

            //show all widgets
            gtk_widget_show_all(window);
            gtk_main();
        }else{
            //initate widgets
            GtkWidget *window, *grid, *payload, *label, *para;
            GdkPixbuf *pixbuf;
            gtk_init(&argc, &argv);
            //create window
            window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
                gtk_window_set_default_size(GTK_WINDOW(window), 300, 10);
                gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
                g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
            //set icon
            pixbuf = gdk_pixbuf_new_from_file("./icons/GPUPM.png", NULL);
                gtk_window_set_icon(GTK_WINDOW(window), pixbuf);
            //create grid for button
            grid = gtk_box_new(GTK_ORIENTATION_VERTICAL, 1);
                gtk_container_add(GTK_CONTAINER(window), grid);
            //create title
            label = gtk_label_new("null");
                gtk_label_set_markup (GTK_LABEL (label), "<span font='17'>\nWelcome to GPU Passthrough Manager!\n</span>");
                gtk_container_add(GTK_CONTAINER(grid), label);
                gtk_box_pack_start(GTK_BOX(grid), label, 0,1,1);
                gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
            //create text info
            para = gtk_label_new("null");
                gtk_label_set_markup (GTK_LABEL (para), "<span font='12'>This program is used for assisting in passing through\ngraphics/audio devices to virtual machines.\nTo begin, click the button below to run initial\ncompatibility checks and configuration adjustments.\nBefore continuing, ensure your system supports IOMMU\nand virtualization is enabled in BIOS. Installation will \nfail if these requirements are not met and your\noperating system may become unstable and/or unusable.\n\n</span>");
                gtk_container_add(GTK_CONTAINER(grid), para);
                gtk_box_pack_start(GTK_BOX(grid), para, 0,1,1);
               gtk_label_set_justify(GTK_LABEL(para), GTK_JUSTIFY_CENTER);
            //first time startup button
            payload = gtk_button_new_with_label("\nStart first time setup\n");
                g_signal_connect(payload, "clicked", G_CALLBACK(first), NULL);
                gtk_box_pack_start(GTK_BOX(grid), payload, 0,1,1);
            //show all widgets
            gtk_widget_show_all(window);
            gtk_main();
            return 0;
            }}else{
            //initate widgets
            GtkWidget *window, *grid, *payload, *label, *para;
            GdkPixbuf *pixbuf;
            gtk_init(&argc, &argv);
            //create window
            window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
                gtk_window_set_default_size(GTK_WINDOW(window), 250, 10);
                gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
                g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
            //set icon    
            pixbuf = gdk_pixbuf_new_from_file("./icons/GPUPM.png", NULL);
                gtk_window_set_icon(GTK_WINDOW(window), pixbuf);
            //create grid for button
            grid = gtk_box_new(GTK_ORIENTATION_VERTICAL, 1);
                gtk_container_add(GTK_CONTAINER(window), grid);
            //RUN AS ROOT
            label = gtk_label_new("null");
                gtk_label_set_markup (GTK_LABEL (label), "<span font='17'>\nRUN AS ROOT!\n</span>");
                gtk_container_add(GTK_CONTAINER(grid), label);
                gtk_box_pack_start(GTK_BOX(grid), label, 0,1,1);
                gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
            //spaces
            para = gtk_label_new("null");
                gtk_label_set_markup (GTK_LABEL (para), "<span font='12'>\n</span>");
                gtk_container_add(GTK_CONTAINER(grid), para);
                gtk_box_pack_start(GTK_BOX(grid), para, 0,1,1);
                gtk_label_set_justify(GTK_LABEL(para), GTK_JUSTIFY_CENTER);
            //returns button
            payload = gtk_button_new_with_label("\nOK\n");
                g_signal_connect(payload, "clicked", G_CALLBACK(returns), NULL);
                gtk_box_pack_start(GTK_BOX(grid), payload, 0,1,1);
            //show all widgets
            gtk_widget_show_all(window);
            gtk_main();
            return 0;        
            
    }
}
