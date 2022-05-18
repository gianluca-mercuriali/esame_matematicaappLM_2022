# esame_matematicaappLM_2022
codice matlab per esame di matematica applicata LM anno 2022
unibo - laurea LM elettronica e telecomunicazioni

ASSIGNMENTS PROJECT EXAM <<matematica applicata>>
  
Given a set of processes i=1,…n each requiring time t(i) and memory m(i) and a "profit" equal to t*m and a processor having
total memory M and an available computing slot of T units.
  
• Define a subset of processes to be executed with maximum total profit and such that
• processes are not interrupted
• processes may be excuted in parallel but at each time instant the memory must not be exceeded

Task
• hint: similar to a 2D nesting problem
• variant: time and memory may be sligtly adjusted by +/- 10% provided their product remains constant (example t=100,m=50, if t=90 m=5000/90=55.55)
• implement greedy and local search approaches for the basic problem and the variant
• implement an iterated local search or a tabu search
• test on random instances with different assortments of processes
