Advanced Deep Reinforcement Learning for Traffic Signal Optimization in Vehicular Networks Using SUMO and Traci
Reinforcement Learning Project by KhansaKhanam, Ram Narayanan, and Nishanth Gopalakrishnan

* Introduction

This project leverages deep reinforcement learning (DRL) and real-time vehicular network data, simulated in SUMO, to optimize traffic signal control. Unlike traditional fixed-duration methods, our approach models intersections as grids, using advanced techniques like DQN, A2C, and PER to improve traffic flow, reduce delays, and enable adaptive traffic management.

* Environment Setting

In RL, an agent interacts with an environment defined by states S and actions A, aiming to maximize its cumulative, discounted reward.

Tools and Frameworks

- SUMO-RL(Provides a reinforcement learning interface for enabling seamless integration of RL algorithms using network and route files for simulation, with error checks.
- Gymnasium(Offers a standardized API for defining environments, states, and actions, compatible with our algorithm)
- State Representation: The environment’s state includes traffic network data (e.g., vehicle positions, traffic light states).
- Action Space: Actions involve controlling traffic signals to minimize overall waiting time across different episodes.
- Step Function: Takes an action and returns the next_state, reward, done (episode status), and info.

* Our Approach
The model uses a SUMO-simulated environment integrated with TraCI to optimize traffic signal actions in a vehicular network. It stores the four-tuple (state, action, reward, next state) in memory and applies prioritized experience replay (PER) for DQN and shared memory for A3C during training. The target network θ− updates slowly for stability, while Double DQN reduces overestimation. Actor-critic methods promote better exploration and performance. The Q-value for each state-action pair is approximated, guiding the optimal policy by selecting the action with the highest Q-value.

Algorithm Execution:
- Initialization - Randomly initialize parameters for the primary and target networks, and set up memory and state.
- Action Selection - Choose actions based on epsilon-greedy policy (DQN/Double DQN) or probabilistic critic selection (Actor-Critic).
- Interaction with Environment - Take action, observe the reward and next state, and store the four-tuple in memory. Use PER for better sampling.
- Network Updates - Calculate loss using the Bellman equation, update the primary network via backpropagation, and update the target network with moving averages of θ.
- Repeat - Continue iterating to refine Q-values and improve action selection.

This method efficiently trains an adaptive traffic light agent to adjust signal timings based on evolving traffic conditions.

- Deep Q-Learning Network with Prioritized Replay Buffer

DQN combines Q-learning with deep neural networks to approximate Q-values. Prioritized Experience Replay (PER) improves training by prioritizing important experiences, allowing the model to learn more effectively from rare or significant transitions.

- Double Deep Q-Learning Network

Double DQN addresses the overestimation bias of Q-learning by using two networks: one for action selection and another for calculating target Q-values. This improves stability and performance in complex environments.

- Advantage Actor Critic Method (A2C)

A2C is a policy-gradient method that uses both an actor (policy network) and a critic (value network). The actor selects actions, while the critic evaluates them. In the synchronous version, multiple agents are trained in parallel, sharing a common policy and value function.

- Asynchronous Actor-Critic Method (A3C)

A3C is similar to A2C but uses multiple agents running in parallel and asynchronously. Each agent updates a global model independently, speeding up training and leading to better environmental exploration.

* Conclusion and Future Work

This paper presents a deep reinforcement learning model for traffic light control using vehicular network data, where states represent traffic signal status and lane density, and rewards are based on waiting time differences between cycles. Complex algorithms are proposed to handle complex traffic scenarios and to make obtaining results more efficient. The model reduces average waiting time by over 20% and outperforms others in learning speed. Future work will focus on improving scalability, incorporating real-time data, and exploring multi-agent and hybrid models for better traffic management.

* References

https://arxiv.org/pdf/1803.11115
https://www.youtube.com/watch?v=MqZmwQoOXw4
https://www.domsauta.com/posts/dqn_sumo/
https://arxiv.org/abs/1511.05952
https://arxiv.org/abs/1509.06461
https://arxiv.org/abs/1602.01783
https://gymnasium.farama.org/
