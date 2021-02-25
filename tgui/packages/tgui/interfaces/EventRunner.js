/**
 * @file
 * @copyright 2020
 * @author Mordent (https://github.com/mordent-goonstation)
 * @license ISC
 */


import { useBackend } from '../backend';
import { Window } from '../layouts';
import ModuleView from './CyborgModuleRewriter/ModuleView';
import { BlockCn } from './CyborgModuleRewriter/style';
import { Button, Section } from '../../components';
import Tools from './Tools';


export const EventRunner = (props, context) => {
    const { act, data } = useBackend(context);
    const { modules } = data; //example
  
    const handleEjectModule = moduleRef => act('module-eject', { moduleRef });
    const handleMoveToolDown = ({ moduleRef, toolRef }) => act('tool-move', {
      dir: 'down',
      moduleRef,
      toolRef,
    });
    const handleSelectModule = moduleRef => act('module-select', { moduleRef });
  
    return (
      <Window
        width={670}
        height={640}
        resizable>
        <Window.Content className={BlockCn} scrollable>
          <ModuleView
            modules={modules}
            onEjectModule={handleEjectModule}
            onMoveToolDown={handleMoveToolDown}
            onSelectModule={handleSelectModule}
          />
        </Window.Content>
      </Window>
    );
  };



const resetOptions = [
  {
    id: 'brobocop',
    name: 'Brobocop',
  }, {
    id: 'medical',
    name: 'Medical',
  }, {
    id: 'mining',
    name: 'Mining',
  },
];

const Module = props => {
  const {
    onMoveToolDown,
    onMoveToolUp,
    onRemoveTool,
    onResetModule,
    tools,
  } = props;

  return (
    <>
      <Section title="Preset">
        {
          resetOptions.map(resetOption => {
            const {
              id,
              name,
            } = resetOption;
            return (
              <Button
                key={id}
                onClick={() => onResetModule(id)}
                title={name}>
                {name}
              </Button>
            );
          })
        }
      </Section>
      <Section title="Tools">
        <Tools
          onMoveToolDown={onMoveToolDown}
          onMoveToolUp={onMoveToolUp}
          onRemoveTool={onRemoveTool}
          tools={tools}
        />
      </Section>
    </>
  );
};


const CyborgModuleRewriter = (props, context) => {
    const { act, data } = useBackend(context);
    const { modules } = data;
  
    const handleEjectModule = moduleRef => act('module-eject', { moduleRef });
    const handleMoveToolDown = ({ moduleRef, toolRef }) => act('tool-move', {
      dir: 'down',
      moduleRef,
      toolRef,
    });
    const handleSelectModule = moduleRef => act('module-select', { moduleRef });
  
    return (
      <Window
        width={670}
        height={640}
        resizable>
        <Window.Content className={BlockCn} scrollable>
          <ModuleView
            modules={modules}
            onEjectModule={handleEjectModule}
            onMoveToolDown={handleMoveToolDown}
            onSelectModule={handleSelectModule}
          />
        </Window.Content>
      </Window>
    );
  };