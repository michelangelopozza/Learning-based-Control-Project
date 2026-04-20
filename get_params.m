function sys = get_params()

    %% Rocket params
    sys.rock.m = 1000;
    sys.rock.b = 4;
    sys.rock.h = 20;
    sys.rock.g = 9.81;
   
    sys.rock.Fc_max = 20000;
    sys.rock.Fl_max = 5000;
    sys.rock.Fr_max = 5000;
    
    %% Environment
    sys.env.px_max = 50;
    sys.env.py_max = 250;
    
    sys.env.py_target_max = 40;
    sys.env.target_py = 35;
    sys.env.py_target_min = 30;
    sys.env.target_px = 0;

    %% Simulation
    sys.sym.theta_max = deg2rad(12);
    sys.sym.theta_min = -deg2rad(12);
    sys.sym.theta_dot_max = 1;
    sys.sym.px_max = sys.env.px_max;
    sys.sym.py_max = sys.env.py_max-(sys.rock.h/2);
    sys.sym.px_dot_max = 50;
    sys.sym.py_dot_max = 50;

    sys.sym.py_min = 10; 
    sys.sym.px_catch_max = sys.env.target_px + 5;
    sys.sym.px_catch_min = sys.env.target_px - 5; 
    sys.sym.py_catch_max = sys.env.target_py + 2;
    sys.sym.py_catch_min = sys.env.target_py - 2; 


    %% Generations
    sys.gen.px_max = 25;
    sys.gen.px_min = -25;
    sys.gen.py_max = 200;
    sys.gen.py_min = 10; 
    sys.gen.theta_min = -abs(sys.sym.theta_max);
    sys.gen.theta_max = abs(sys.sym.theta_max);
    sys.gen.theta_dot_min = -10;
    sys.gen.theta_dot_max = 10;

end